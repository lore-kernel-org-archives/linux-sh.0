From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Mon, 01 Jun 2009 11:34:52 +0000
Subject: Re: [PATCH] Fix SCI console output
Message-Id: <4.2.0.58.J.20090601195932.03d94370@router.itonet.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4.2.0.58.J.20090601123439.00b52740@router.itonet.co.jp>
In-Reply-To: <4.2.0.58.J.20090601123439.00b52740@router.itonet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At 13:59 09/06/01 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
>On Mon, Jun 01, 2009 at 12:53:41PM +0900, SUGIOKA Toshinobu wrote:
>> Fix SCI transmission sequence in console output function.
>> 
>> Signed-off-by: Toshinobu Sugioka <sugioka@itonet.co.jp>
>> 
>This change was intentional. Do you have a use case where this causes a
>problem? 

On my SH7709S board, after switching to console(SCI), output is not correct.
Linefeed code output twice, and the first character of the next line is
not seen.

Like follows.
--- console output ----
SuperH SCI(F) driver initialized
sh-sci: ttySC0 at MMIO 0xfffffe80 (irq = 25) is a sci
console handover: boot [bios0] -> real [ttySC0]

h-sci: ttySC1 at MMIO 0xa4000150 (irq = 59) is a scif

h-sci: ttySC2 at MMIO 0xa4000140 (irq = 55) is a irda

oop: module loaded
---------------------------
Atfer applying the patch, I got normal output.

According to sh7709s hardware manual, SCI tx flow-chart says
 (1) wait until TDRE=1
 (2) write data to TDR
 (3) clear TDRE

Why did you changed the sequence ?

SUGIOKA Toshinobu

