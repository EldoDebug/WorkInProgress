import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
export const distroID = Utils.exec(`bash -c 'cat /etc/os-release | grep "^ID=" | cut -d "=" -f 2 | sed "s/\\"//g"'`).trim();

export const getDistroIcon = () => {
    if(distroID == 'arch') return 'archlinux-symbolic';
    if(distroID == 'endeavouros') return 'endeavouros-symbolic';
    if(distroID == 'cachyos') return 'cachyos-symbolic';
    if(distroID == 'nixos') return 'nixos-symbolic';
    return 'linux-symbolic';
}

export const getDistroName = () => {
    if(distroID == 'arch') return 'Arch Linux';
    if(distroID == 'endeavouros') return 'EndeavourOS';
    if(distroID == 'cachyos') return 'CachyOS';
    if(distroID == 'nixos') return 'NixOS';
    return 'Linux';
}