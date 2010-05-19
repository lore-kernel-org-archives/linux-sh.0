From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 19 May 2010 08:43:52 +0000
Subject: Re: [PATCH/RFC] sh: simplify register access macros in the SCI serial
Message-Id: <Pine.LNX.4.64.1005191042200.3099@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005191028560.3099@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005191028560.3099@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 19 May 2010, Guennadi Liakhovetski wrote:

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> well, actually, I think, as long size is a constant, I think, even the 
> original macros would be resolved at compile time, wouldn't they? And they 
> have the advantage to also supporting non-constants. Whereas my version 
> explicitly requires constants, but looks a bit easier to me... Anyway, I 
> thought I just propose it, but I wouldn't be too upset if it just gets 
> dropped.

A short follow-up: a slightly better possibility, than changing register 
definitions from size 0 to size 16, would be to define iowrite0 and 
ioread0 as suitable NOPs...

Thanks
Guennadi

> 
>  drivers/serial/sh-sci.h |   36 ++++++++++++++----------------------
>  1 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
> index f70c49f..151c41f 100644
> --- a/drivers/serial/sh-sci.h
> +++ b/drivers/serial/sh-sci.h
> @@ -307,17 +307,9 @@
>  #define SCI_EVENT_WRITE_WAKEUP	0
>  
>  #define SCI_IN(size, offset)					\
> -  if ((size) = 8) {						\
> -    return ioread8(port->membase + (offset));			\
> -  } else {							\
> -    return ioread16(port->membase + (offset));			\
> -  }
> +    return ioread ## size(port->membase + (offset));
>  #define SCI_OUT(size, offset, value)				\
> -  if ((size) = 8) {						\
> -    iowrite8(value, port->membase + (offset));			\
> -  } else if ((size) = 16) {					\
> -    iowrite16(value, port->membase + (offset));			\
> -  }
> +    iowrite ## size(value, port->membase + (offset));
>  
>  #define CPU_SCIx_FNS(name, sci_offset, sci_size, scif_offset, scif_size)\
>    static inline unsigned int sci_##name##_in(struct uart_port *port)	\
> @@ -435,7 +427,7 @@ SCIF_FNS(SCFCR,  0x18, 16)
>  SCIF_FNS(SCFDR,  0x1c, 16)
>  SCIF_FNS(SCxTDR, 0x20,  8)
>  SCIF_FNS(SCxRDR, 0x24,  8)
> -SCIF_FNS(SCLSR,  0x00,  0)
> +SCIF_FNS(SCLSR,  0x00, 16)
>  #elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
>        defined(CONFIG_CPU_SUBTYPE_SH7724)
>  SCIx_FNS(SCSMR,  0x00, 16, 0x00, 16)
> @@ -444,7 +436,7 @@ SCIx_FNS(SCSCR,  0x08, 16, 0x08, 16)
>  SCIx_FNS(SCxTDR, 0x20,  8, 0x0c,  8)
>  SCIx_FNS(SCxSR,  0x14, 16, 0x10, 16)
>  SCIx_FNS(SCxRDR, 0x24,  8, 0x14,  8)
> -SCIx_FNS(SCSPTR, 0,     0,    0,  0)
> +SCIx_FNS(SCSPTR, 0,    16,    0, 16)
>  SCIF_FNS(SCTDSR, 0x0c,  8)
>  SCIF_FNS(SCFER,  0x10, 16)
>  SCIF_FNS(SCFCR,  0x18, 16)
> @@ -467,24 +459,24 @@ SCIF_FNS(SCFCR,                      0x0c,  8, 0x18, 16)
>  SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
>  SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
>  SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
> -SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
> -SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
> +SCIF_FNS(SCSPTR,			0, 16, 0x24, 16)
> +SCIF_FNS(SCLSR,				0, 16, 0x28, 16)
>  #elif defined(CONFIG_CPU_SUBTYPE_SH7763)
> -SCIF_FNS(SCFDR,				0,  0, 0x1C, 16)
> -SCIF_FNS(SCSPTR2,			0,  0, 0x20, 16)
> -SCIF_FNS(SCLSR2,			0,  0, 0x24, 16)
> +SCIF_FNS(SCFDR,				0, 16, 0x1C, 16)
> +SCIF_FNS(SCSPTR2,			0, 16, 0x20, 16)
> +SCIF_FNS(SCLSR2,			0, 16, 0x24, 16)
>  SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
>  SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
> -SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
> -SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
> +SCIF_FNS(SCSPTR,			0, 16, 0x24, 16)
> +SCIF_FNS(SCLSR,				0, 16, 0x28, 16)
>  #else
>  SCIF_FNS(SCFDR,                      0x0e, 16, 0x1C, 16)
>  #if defined(CONFIG_CPU_SUBTYPE_SH7722)
> -SCIF_FNS(SCSPTR,                        0,  0, 0, 0)
> +SCIF_FNS(SCSPTR,                        0, 16, 0, 16)
>  #else
> -SCIF_FNS(SCSPTR,                        0,  0, 0x20, 16)
> +SCIF_FNS(SCSPTR,                        0, 16, 0x20, 16)
>  #endif
> -SCIF_FNS(SCLSR,                         0,  0, 0x24, 16)
> +SCIF_FNS(SCLSR,                         0, 16, 0x24, 16)
>  #endif
>  #endif
>  #define sci_in(port, reg) sci_##reg##_in(port)
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
