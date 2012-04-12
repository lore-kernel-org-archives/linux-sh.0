From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Apr 2012 10:22:11 +0000
Subject: Re: [PATCH v3] serial: sh-sci: modify sci_break_ctl()
Message-Id: <20120412102211.GC7368@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F863CF6.1040607@renesas.com>
In-Reply-To: <4F863CF6.1040607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 12, 2012 at 11:24:54AM +0900, Shimoda, Yoshihiro wrote:
> SCIF modules which have SCSPTR can output the break signal.
> This patch supports it.
> 
> This patch tested on sh7757lcr.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v3:
>   - modify a method which detects SCSPTR
> 
Looks good, applied.
