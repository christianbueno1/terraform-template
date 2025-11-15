# droplet-do


Tiny OpenTofu module to create a DigitalOcean Droplet for development/testing.

Usage (local)
1. Install OpenTofu (the repo CI installs a pinned version for checks). Locally you already have the `tofu` CLI available.
2. Provide your DigitalOcean API token. Options:
   - Create `secrets.auto.tfvars` with `do_token = "<TOKEN>"` (recommended for local dev)
   - Export `TF_VAR_do_token` in your shell before running OpenTofu.
      ```
      export TF_VAR_do_token="your_digitalocean_token_here"
      ```
   - Terraform CLI arguments: Pass the value directly with the -var flag during terraform plan or terraform apply.
      ```
      terraform apply -var="do_token=your_digitalocean_token_here"
      ```
Example (local):

Create `secrets.auto.tfvars` next to these files with:

```
do_token = "your-digitalocean-token-here"
```

Then:

```bash
tofu init
tofu validate
#
# tofu plan
tofu plan -out plan.tfplan
#
# tofu apply plan.tfplan
tofu apply "plan.tfplan"

# show outputs
tofu output droplet_ip
```

Customizing
- Change `size`, `image`, `region`, `droplet_name`, or `ssh_key_ids` by setting variables via a `.tfvars` file or `-var` flags.

Notes
- The provider currently reads `do_token` as an input variable. You can set it via `TF_VAR_do_token`.
- This module does not configure a remote backend; you may add one if you want state stored remotely.

CI
- The repository GitHub Actions workflow installs OpenTofu (pinned to v1.10.7) and runs `tofu fmt` and `tofu validate` for changes under `droplet-do/`.

DigitalOcean token permissions
--------------------------------

When applying resources that include `tags`, the DigitalOcean API may try to create tags on your behalf. If your API token lacks the permission to create tags you'll see an error like:

```
Error: You are missing the required permission tag:create
```

Fixes:

- Option A (recommended): Create a new Personal Access Token in the DigitalOcean control panel with read+write permissions (write scope allows creating tags). Then set that token in `secrets.auto.tfvars` or `TF_VAR_do_token` before running `tofu apply`.

   1. Log in to https://cloud.digitalocean.com -> API -> Tokens & Keys -> "Generate New Token".
   2. Give it a name and enable Write access.
   3. Save the token somewhere safe and add it locally in `secrets.auto.tfvars`:

       ```hcl
       do_token = "your-new-token-here"
       ```

- Option B: Pre-create the tags (requires a token with tag:create permission). With doctl installed and authenticated you can run:

       ```bash
       doctl compute tag create web env:dev
       ```

   After tags exist, applying the droplet with a token that can only attach existing tags (but not create them) may succeed.

If you want, I can update the module to skip creating tags automatically and instead only attach existing tags (but you'll still need the tags in your account). Let me know which approach you prefer.

