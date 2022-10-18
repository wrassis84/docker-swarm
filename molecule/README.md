### Molecule usage
1. Update system packages and install `pip3`:
```shell
sudo apt update && sudo apt install python3-pip
```
2. Since this example will be using `docker` as the infrastructure source, the `docker-py` package is required as well:
```shell
pip3 install molecule docker
```
3. Install the *linters* for `ansible` and `yaml`:
For more details: https://ansible-lint.readthedocs.io/ and https://yamllint.readthedocs.io/en/stable/
```shell
pip3 install "ansible-lint[yamllint]"
```
4. Create the files for `ansible` and `yaml` *linters*:
```shell
touch .ansible-lint yamllint
```
5. Now, execute the *linters* on directory project:
```shell
ansible-lint
```
```shell
yamllint .
```
6. Initialize the `molecule` test. Run the command below for existing *roles*.
```shell
molecule init scenario default
```
7. To test, simply run this command:
For more details: https://molecule.readthedocs.io/en/latest/getting-started.html
```shell
molecule test
```
