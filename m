From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 10 May 2016 07:46:24 +0000
Subject: Re: [PATCH RESEND 12/12] of: Add sh support
Message-Id: <87bn4epd7z.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
	<1462079316-27771-13-git-send-email-ysato@users.sourceforge.jp>
	<CAL_JsqKTaJEFtPm-R3WS23S0Zhvm4T2d3_dscHB2o-KGUfkqfQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKTaJEFtPm-R3WS23S0Zhvm4T2d3_dscHB2o-KGUfkqfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 02 May 2016 21:35:28 +0900,
Rob Herring wrote:
> 
> On Sun, May 1, 2016 at 12:08 AM, Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > sh fdt access in VA. But memory reservation use PA.
> > So sh need convert to PA.
> >
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  drivers/of/fdt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 3349d2a..fb357be 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -593,6 +593,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
> >                 fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
> >                 if (!size)
> >                         break;
> > +#ifdef CONFIG_SUPERH
> > +               base = virt_to_phys(base);
> > +#endif
> >                 early_init_dt_reserve_memory_arch(base, size, 0);
> 
> This is not right. base is already a physical address and
> early_init_dt_reserve_memory_arch takes a physical address. The
> default implementation using memblock also works on physical
> addresses. It is a weak function so you can override it if you need to
> do something special. But it seems something else is wrong here if you
> need this.

Thank you very much for your advice.
The function of the sh specific is defined.

> Rob

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
