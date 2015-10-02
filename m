From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 02 Oct 2015 01:00:52 +0000
Subject: RE: [PATCH 1/2] dmaengine: usb-dmac: Fix crash on runtime suspend
Message-Id: <SG2PR06MB0919E72456F1D40BA6E4CB04D84B0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
 <1443684138-32252-2-git-send-email-geert+renesas@glider.be>
 <SG2PR06MB091969749911331385AB7E83D84C0@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <560D268F.8090705@cogentembedded.com>
In-Reply-To: <560D268F.8090705@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Sergei-san,

> Sent: Thursday, October 01, 2015 9:27 PM
>=20
> Hello.
>=20
> On 10/1/2015 1:53 PM, Yoshihiro Shimoda wrote:
>=20
> >> If CONFIG_PREEMPT=3Dy:
>=20
>     Actually, it happens even with CONFIG_PREEMPT_VOLUNTARY=3Dy.
>=20
> >>      Unable to handle kernel NULL pointer dereference at virtual addre=
ss 00000014
> >>      pgd =3D c0003000
> >>      [00000014] *pgd=80000040004003, *pmd=00000000
> >>      Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> >>      Modules linked in:
> >>      CPU: 0 PID: 17 Comm: kworker/0:1 Tainted: G        W       4.3.0-=
rc3-koelsch-022
> >>      71-g705498fc5e6a5da8-dirty #1789
> >>      Hardware name: Generic R8A7791 (Flattened Device Tree)
> >>      Workqueue: pm pm_runtime_work
> >>      task: ef578e40 ti: ef57a000 task.ti: ef57a000
> >>      PC is at usb_dmac_chan_halt+0xc/0xc0
> >>      LR is at usb_dmac_runtime_suspend+0x28/0x38
> >>      pc : [<c023c880>]    lr : [<c023c95c>]    psr: 80000113
> >>      sp : ef57bdf8  ip : 00000008  fp : 00000003
> >>      r10: 00000008  r9 : c06ab928  r8 : ef49e810
> >>      r7 : 00000000  r6 : 000000ac  r5 : ef770010  r4 : 00000000
> >>      r3 : 00000000  r2 : 8ffc2b84  r1 : 00000000  r0 : ef770010
> >>      Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kern=
el
> >>      Control: 30c5307d  Table: 40003000  DAC: fffffffd
> >>      Process kworker/0:1 (pid: 17, stack limit =3D 0xef57a210)
> >>      Stack: (0xef57bdf8 to 0xef57c000)
> >>
> >>      [...
> >>
> >>      [<c023c880>] (usb_dmac_chan_halt) from [<c023c95c>] (usb_dmac_run=
time_suspend+0x28/0x38)
> >>      [<c023c95c>] (usb_dmac_runtime_suspend) from [<c027b25c>] (pm_gen=
pd_runtime_suspend+0x74/0x23c)
> >>
> >> This happens because usb_dmac_probe() calls pm_runtime_put() before
> >> usb_dmac_chan_probe(), leading to the device being suspended before the
> >> DMA channels are initialized, causing a NULL pointer dereference.
> >>
> >> Move the call to pm_runtime_put() to the end of usb_dmac_probe() to fix
> >> this.
> >>
> >> Add a check to usb_dmac_runtime_suspend() to prevent the crash from
> >> happening in the error path.
> >>
> >> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > I could not duplicate this issue completely on Lager.
> > Even if I enabled ealyprintk, I didn't see the panic log.
> > (Several kernel message appeared, and then the kernel hung.)
>=20
>     I guess you also need to specify console=3D. The device tree console
> assignment (from the "stdout-path" prop) happens too late, the console ge=
ts
> switched to /dev/tty0 first. I forgot to mention that the pseudo-console
> (CONFIG_VT) should be disabled as well.

Thank you for your comment!
I was able to look the panic log if I added specify console=3D in the boota=
rgs.
(Even if CONFIG_VT=3Dy, the log appeared.)

> > Anyway, I tested this patch that kernel could boot correctly even if CO=
NFIG_PREEMPT=3Dy.
> > So,
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
>     Thank you. :-)

You're welcome! And, thank you for the report.

Best regards,
Yoshihiro Shimoda

> > Best regards,
> > Yoshihiro Shimoda
>=20
> MBR, Sergei
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
