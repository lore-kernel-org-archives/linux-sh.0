From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 06 Apr 2012 05:39:00 +0000
Subject: Re: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <4F7E8174.7030604@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7E3FE2.4050902@renesas.com>
In-Reply-To: <4F7E3FE2.4050902@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/04/06 14:11, Simon Horman wrote:
> On Fri, Apr 06, 2012 at 12:50:00PM +0900, Shimoda, Yoshihiro wrote:
>>
>> If userland calls ioctl with TIOCSBRK/TIOCCBRK, the sci_break_ctl
>> is called. After TIOCSBRK we cannot send data from SCIF.
>> After TIOCCBRK, we can send data from SCIF.
> 
> Thanks, that make a lot of sense.
> 
> Unfortunately the ecovec doesn't exercise the new code
> as the regtype of its scif is SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
> but your code only operates on SCIx_SH4_SCIF_REGTYPE.

Sorry I forgot that the SH7724 has SCIF and SCIFA.
The ecovec uses SCIF, and it doesn't have SCSPTR.
I checked the ecovec schematics, but it cannot use SCIFA because
other functions use the multiplex pins.

Best regards,
Yoshihiro Shimoda
