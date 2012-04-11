From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Apr 2012 09:36:40 +0000
Subject: Re: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <4F8550A8.30904@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7E3FE2.4050902@renesas.com>
In-Reply-To: <4F7E3FE2.4050902@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/04/11 13:28, Paul Mundt wrote:
> On Fri, Apr 06, 2012 at 02:39:00PM +0900, Shimoda, Yoshihiro wrote:
>>
>> Sorry I forgot that the SH7724 has SCIF and SCIFA.
>> The ecovec uses SCIF, and it doesn't have SCSPTR.
> 
> Well, one thing that you can do is test for the SCSPTR existence and
> simply not care about the port type. This is roughly what the generic
> sci_init_pins() does for example.
> 
> You would have to ensure that the bits you are twiddling also exist for
> the SCIx_SH2_SCIF_FIFODATA_REGTYPE, SCIx_SH2_SCIF_FIFODATA_REGTYPE, and
> SCIx_SH4_SCIF_FIFODATA_REGTYPE, though.

Thank you for the suggestion. I will modify the code.

>> I checked the ecovec schematics, but it cannot use SCIFA because
>> other functions use the multiplex pins.
>>
> You should be able to plug them in for the port and let the sh-sci driver
> try to grab the port. The port will simply be skipped if pin demux fails.
> Take a look at 50f0959ad4f9ac1c5ee208bb820de299a1b3730b for an idea of
> how to wire it up.
> 

I'm sorry, I don't understand this comment.
I think that if the sh-sci driver grab the port, other driver cannot
work correctly when other driver is working.

Best regards,
Yoshihiro Shimoda
