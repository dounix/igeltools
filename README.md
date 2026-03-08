# igeltools

Tools for deploying and managing IGEL OS thin clients.

## ISO — Unattended Install ISO Creator

`iso/create_unattended.sh` takes an IGEL OS Creator (OSC) ISO image and produces a modified ISO that performs an unattended installation.

It works by extracting the GRUB boot configuration from the source ISO:

- Enable `osc_unattended=true` in the boot options

### Dependencies

- `sed`
- `xorriso`

### Usage

```bash
cd iso
./create_unattended.sh <osc_iso_file> [<osc_iso_file> ...]
```

The ISO will be created in your current directory, with `_unattended` appended.

## Terraform — IGEL UMS Thin Clients on Proxmox

Terraform configurations for provisioning IGEL OS thin client VMs on a Proxmox VE 9 cluster using the UMS (Universal Management Suite).

Configuration lives under `terraform/`.
