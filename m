From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 22 Feb 2008 08:40:43 +0000
Subject: Re: IRQ3 seems to work now for SH7709
Message-Id: <aec7e5c30802220040x2171711co904c25afc250563c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 22, 2008 at 5:30 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>  Apply the attached patch and request the irq using IRQF_TRIGGER_LOW.
>  If I'm right then that should configure IRQ sensing for you in ICR1 -
>  look in intc.c for IRQ_TYPE_LEVEL_LOW. You can also play around with
>  different edge trigger modes - and then you probably need a fix like
>  the one you posted - just remember that high level isn't available on
>  sh770x but there are no checks in the intc code for that at the
>  moment...

Uhm, i forgot that the patch happens to modify a sh7705 related file.
So you need to do some work to apply it to sh770x...

Thanks,

/ magnus
