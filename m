From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 26 Oct 2015 00:30:27 +0000
Subject: Re: [PATCH v2 1/2] dmaengine: sh: usb-dmac: Fix crash on runtime suspend
Message-Id: <20151026001825.GA3690@vkoul-mobl.iind.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445767774-24001-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445767774-24001-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sun, Oct 25, 2015 at 11:09:33AM +0100, Geert Uytterhoeven wrote:
> If CONFIG_PREEMPT=3Dy:
>=20
>     Unable to handle kernel NULL pointer dereference at virtual address 0=
0000014
>     pgd =3D c0003000
>     [00000014] *pgd=80000040004003, *pmd=00000000
>     Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>     Modules linked in:
>     CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W       4.3.0-rc3-=
koelsch-022
>     71-g705498fc5e6a5da8-dirty #1789
>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>     Workqueue: pm pm_runtime_work
>     task: ef578e40 ti: ef57a000 task.ti: ef57a000
>     PC is at usb_dmac_chan_halt+0xc/0xc0
>     LR is at usb_dmac_runtime_suspend+0x28/0x38
>     pc : [<c023c880>]    lr : [<c023c95c>]    psr: 80000113
>     sp : ef57bdf8  ip : 00000008  fp : 00000003
>     r10: 00000008  r9 : c06ab928  r8 : ef49e810
>     r7 : 00000000  r6 : 000000ac  r5 : ef770010  r4 : 00000000
>     r3 : 00000000  r2 : 8ffc2b84  r1 : 00000000  r0 : ef770010
>     Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>     Control: 30c5307d  Table: 40003000  DAC: fffffffd
>     Process kworker/0:1 (pid: 17, stack limit =3D 0xef57a210)
>     Stack: (0xef57bdf8 to 0xef57c000)
>=20
>     [...
>=20
>     [<c023c880>] (usb_dmac_chan_halt) from [<c023c95c>] (usb_dmac_runtime=
_suspend+0x28/0x38)
>     [<c023c95c>] (usb_dmac_runtime_suspend) from [<c027b25c>] (pm_genpd_r=
untime_suspend+0x74/0x23c)
>=20
> This happens because usb_dmac_probe() calls pm_runtime_put() before
> usb_dmac_chan_probe(), leading to the device being suspended before the
> DMA channels are initialized, causing a NULL pointer dereference.
>=20
> Move the call to pm_runtime_put() to the end of usb_dmac_probe() to fix
> this.
>=20
> Add a check to usb_dmac_runtime_suspend() to prevent the crash from
> happening in the error path.

This worked, applied both now

Thanks

--=20
~Vinod
