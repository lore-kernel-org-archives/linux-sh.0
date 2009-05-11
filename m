From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 09:59:37 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <aec7e5c30905110259s9cf56c0m3d59b828cf9207a3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 6:44 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> On Mon, May 11, 2009 at 06:01:08PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Update intc tables and platform data to use one linux irq
>> per maskable interrupt source instead of keeping the one-to-one
>> mapping between vectors and linux irqs.
>>
>> This fixes potential irq masking issues for sh7760 hardware
>> blocks such as DMAC/TMU2/REF.
>
> With this patch applied, my 7760 system no longer boots. =A0I'll
> try to figure out why as soon as I get my JTAG probe back.

Oops, that's no good. I'm converting sh7760 to make use of the new
timer driver, and while at it I wanted to fix the vectors because they
looked like they will generate warnings...

Without this patch, do you see intc warning printouts like "intc:
missing unique irq mask for..."?

Are you using DMAC, TMU2 or REF on your system?

Thanks for your help!

/ magnus
