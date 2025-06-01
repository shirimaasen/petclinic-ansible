**PetClinic + LVM-backed `/var` on AL2023 EC2**

> **Overview**: Quickly deploy Spring PetClinic behind Nginx and move `/var` to a separate LVM volume.

---

## 1. Infrastructure (Terraform)

* **EC2 Instance**: Amazon Linux 2023 with basic setup via user-data.
* **Second EBS Volume**: Attached as `/dev/xvdf` for `/var`

Create your Terraform `backend.tf`
```
terraform {
  backend "s3" {
    bucket         = "your-bucket"
    key            = "petlcinic-ansible/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "your-lock-table"
  }
}
```

## 2. Application Setup (Ansible)

1. **Install Java, Git, Maven**.
2. **Clone & build** Spring PetClinic from GitHub.
3. **Systemd Service**: Runs `petclinic.jar` on port 8080.
4. **Nginx**: Reverse proxy from port 80 → 8080.

## 3. `/var` Migration to LVM (Ansible)

1. **Install `lvm2` & `rsync`**.
2. **Create LVM**:

   * `pvcreate /dev/xvdf` → `vgcreate var_vg` → `lvcreate var_lv`.
3. **Format & mount** new LV at `/mnt/var_new`.
4. **Rsync**: Copy old `/var/*` → `/mnt/var_new/*`.
5. **Update `fstab`** and rename `/var` → `/var.old`.
6. **Create new `/var`** and mount LV as `/var`.

## 4. Validation Steps

* Check `/var` mount: `mount | grep /var` → should show `/dev/mapper/var_vg-var_lv`.
* Old data in `/var.old`.
* Confirm logs writable: `sudo touch /var/log/test.log`.
* Reboot to ensure `fstab` persists.

## How to run Ansible Playbooks
```bash
ansible-playbook -i inventory.yml lvm.yml -e ec2_ip=<EC2-IP>
```

---

**Result**: PetClinic runs at `http://<EC2-IP>`. `/var` is now on a flexible LVM volume; old contents remain in `/var.old` as a backup.
