include:
  - epel

python26:
  pkg.installed:
    - require:
      - pkg: epel
