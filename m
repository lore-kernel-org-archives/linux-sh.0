From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Apr 2010 08:30:28 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <r2naec7e5c31004210130rf22ec43cnda564004df8cf836@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Kawasaki-san,

2010/4/11 Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>:
> Hello Magnus,
>
> I'm in trouble with qemu-sh serial console. =A0Don't you have any
> guide on this trouble?

Yes, I think the defconfig is missing one thing. Please try setting
CONFIG_SERIAL_SH_SCI_NR_UARTS=3D2. See below.

> With the patch, qemu-sh serial console doesn't work.
> The emulated device is r2d+.
>
> =A0- no earlyprintk option
> =A0... Qemu carshes with assertion. No kernel boot log printed.
> =A0 =A0 =A0I guess it touches sh-sci.0 registers, which qemu doesn't supp=
ort.

Hm, I'm not sure why this happens. Did you update the kernel command
line to use ttySC1?

This commit in linux-2.6 git may be useful:

 cd5f107628ab89c5dec5ad923f1c27f4cba41972

> =A0- earlyprintk=3Dsh-sci.1
> =A0... Qemu boots up with kernel boot log output,
> =A0 =A0 =A0but the log message stops with
> =A0 =A0 =A0"turn off boot console early_ttySC0' message.
> =A0 =A0 =A0No login prompt appears.
> =A0- earlyprintk=3Dsh-sci.1,115200,keep
> =A0... The message "turn off boots up ..." disappears, but no
> =A0 =A0 =A0login prompt appears.

I think this is because CONFIG_SERIAL_SH_SCI_NR_UARTS is set to 1. Or
perhaps is your user space still using ttySC0 instead of ttySC1?

Does updating CONFIG_SERIAL_SH_SCI_NR_UARTS to 2 solve your issue?

Thanks for the report and sorry about the breakage.

/ magnus
