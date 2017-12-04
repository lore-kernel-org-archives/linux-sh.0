From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Mon, 04 Dec 2017 15:23:20 +0000
Subject: Re: [PATCH] arch/sh: fix Ethernet clock for SH7786
Message-Id: <20171204162320.3ca823af@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello,

On Mon, 4 Dec 2017 15:58:42 +0100, Geert Uytterhoeven wrote:

> The clock is optional, right? Do you need it? It's "needed" for WoL only,
> but that dependency is planned to be removed, cfr. "sh_eth: Remove obsole=
te
> explicit clock handling for WoL".

Hm, that's a good point what you raise here. Indeed looking at the
code, the clock isn't enabled unless you go in suspend() and WoL
support is enabled. I don't go into suspend, and I don't have WoL
enabled, but if I revert my patch, the kernel hangs at:

Generic PHY sh7786-ether-0:00: attached PHY driver [Generic PHY] (mii_bus:p=
hy_addr=3Dsh7786-ether-0:00, irq=3DPOLL)
Waiting up to 110 more seconds for network.

(I booting over NFS, so the kernel tries to get an IP address over DHCP
at boot time)

With my patch applied:

Generic PHY sh7786-ether-0:00: attached PHY driver [Generic PHY] (mii_bus:p=
hy_addr=3Dsh7786-ether-0:00, irq=3DPOLL)
sh-eth sh7786-ether.0 eth0: Link is Up - 100Mbps/Full - flow control rx/tx
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.0.254, my address is 192.168.0.202
IP-Config: Complete:
     device=3Deth0, hwaddr=D4:81:d7:45:df:5a, ipaddr=192.168.0.202, mask%5.=
255.255.0, gw=192.168.0.254
     host=192.168.0.202, domain=3Dlan, nis-domain=3D(none)
     bootserver=192.168.0.254, rootserver=192.168.0.11, rootpath=3D     nam=
eserver0=192.168.0.254
VFS: Mounted root (nfs filesystem) on device 0:13.
devtmpfs: mounted
Freeing unused kernel memory: 132K

So it seems like getting the reference to the clock has some
side-effect. I guess this needs more debugging :-)

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
