From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 02 Feb 2011 03:44:01 +0000
Subject: build error in ehci-hcd when disable PCI bus
Message-Id: <4D48D301.9080705@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Paul,

I found the build error when I am debugging other board.
Also I can duplicate this issue on sdk7786 when the PCI bus is disabled.
I tested linux-2.6.38-rc3.
Do you think what souce code should I fix?

******* build Log *******
In file included from drivers/usb/host/ehci-hcd.c:340:
drivers/usb/host/ehci-sched.c: In function =91ehci_quirk_amd_L1=92:
drivers/usb/host/ehci-sched.c:1606: error: implicit declaration of function=
 =91outb_p=92
drivers/usb/host/ehci-sched.c:1607: error: implicit declaration of function=
 =91inb_p=92
drivers/usb/host/ehci-sched.c:1611: error: implicit declaration of function=
 =91outl_p=92
drivers/usb/host/ehci-sched.c:1614: error: implicit declaration of function=
 =91inl_p=92
make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
**************************

Best regards,
Yoshihiro Shimoda

