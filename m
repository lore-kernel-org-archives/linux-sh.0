From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Apr 2012 07:59:44 +0000
Subject: Re: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <20120409075944.GC11820@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7E3FE2.4050902@renesas.com>
In-Reply-To: <4F7E3FE2.4050902@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 06, 2012 at 09:59:14AM +0900, Shimoda, Yoshihiro wrote:
> SCIF modules which have SCSPTR can output the break signal.
> This patch supports it.
> 
> This patch tested on sh7757lcr.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v2:
>   - add serial_sci.h
>   - change sci_in/sci_out to serial_port_in/serial_port_out
> 
Looks good to me, I'll queue it up, thanks.
