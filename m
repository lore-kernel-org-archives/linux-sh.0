From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 22 Feb 2008 08:30:07 +0000
Subject: Re: IRQ3 seems to work now for SH7709
Message-Id: <aec7e5c30802220030s5f7f0bc1x6e1271c292e90d21@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_5458_3789268.1203669007679"
List-Id: <linux-sh.vger.kernel.org>
References: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

------=_Part_5458_3789268.1203669007679
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Kristoffer,

I think you are right. IRQn pins may need some special care on sh3.
But only if the pins are in individual mode (as IRQn - not IRLn) _and_
configured as edge triggered. I think you are about the only person on
this planet who is using the upstream kernel on sh3. Thanks for
testing. =)

You are seeing this because you probably used plat_irq_setup_pins() to
select IRQ mode and edge triggered happens to be the default unless
ICR1 is changed. And the current code doesn't do anything with ICR1
since the irq doesn't support sense selection. Yet.

We may need to come up with a fix for edge triggered mode... Such a
fix is of course cpu specific but it probably needs to be implemented
right in the middle of the generic intc code so I'm not so happy to
add it unless it's absolutely necessary.

What about if you use level triggered mode instead? Not sure if your
device hooked up to the IRQ pin supports that though.

Apply the attached patch and request the irq using IRQF_TRIGGER_LOW.
If I'm right then that should configure IRQ sensing for you in ICR1 -
look in intc.c for IRQ_TYPE_LEVEL_LOW. You can also play around with
different edge trigger modes - and then you probably need a fix like
the one you posted - just remember that high level isn't available on
sh770x but there are no checks in the intc code for that at the
moment...

/ magnus

On Fri, Feb 22, 2008 at 5:29 AM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
> Greetings,
>
>  IRQ0->IRQ5 needs to be silenced by first setting priority 0 and then mask out the affected bit in IRR0. This was done previously in 2.6.17 in the ipr handler. This is also according to SH7709 manual.
>
>  This can be found inside 2.6.17 with linuxsh patches applied :
>
>  static void mask_and_ack_ipr(unsigned int irq)
>
>   89 {
>   90         disable_ipr_irq(irq);
>   91
>   92 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_SH7709) || \
>   93     defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_SH7705)
>   94         /* This is needed when we use edge triggered setting */
>   95         /* XXX: Is it really needed? */
>   96         if (IRQ0_IRQ <= irq && irq <= IRQ5_IRQ) {
>   97                 /* Clear external interrupt request */
>   98                 int a = ctrl_inb(INTC_IRR0);
>   99                 a &= ~(1 << (irq - IRQ0_IRQ));
>   100                 ctrl_outb(a, INTC_IRR0);
>   101         }
>   102 #endif
>   103 }
>
>  (you can access entire file at http://www.jlime.org/gitweb?p=jlime-stable.git;a=blob;f=arch/sh/kernel/cpu/irq/ipr.c;h=e55150ed085619d5962e039e1ebb2a4fdc2e9b15;hb=3f3554525f5c300a6e41d0aae01673c45e9098c3)
>
>  I added minor code to intc_disable() just to test it
>
>  #ifdef CONFIG_CPU_SUBTYPE_SH7709
>         if (irq = 35) {                <--- my touchscreen IRQ
>                 int a = inb(IRR0);
>                 a &= ~(1 << 3);
>                 outb(a, IRR0);
>         }
>  #endif
>
>  And the result was that the interrupt no longer keeps feeding data instead only when touchscreen is actually touched, so seems valid.
>
>  Best wishes
>  Kristoffer
>

------=_Part_5458_3789268.1203669007679
Content-Type: application/octet-stream;
 name=linux-2.6.25-rc-sh770x-irq-sensing-20080222.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcyh4ov71
Content-Disposition: attachment;
 filename=linux-2.6.25-rc-sh770x-irq-sensing-20080222.patch

LS0tIDAwMDEvYXJjaC9zaC9rZXJuZWwvY3B1L3NoMy9zZXR1cC1zaDc3MDUuYworKysgd29yay9h
cmNoL3NoL2tlcm5lbC9jcHUvc2gzL3NldHVwLXNoNzcwNS5jCTIwMDgtMDItMjIgMTY6NTc6Mzcu
MDAwMDAwMDAwICswOTAwCkBAIC04Niw4ICs4NiwxMyBAQCBzdGF0aWMgc3RydWN0IGludGNfdmVj
dCB2ZWN0b3JzX2lycVtdIF9fCiAJSU5UQ19WRUNUKElSUTIsIDB4NjQwKSwgSU5UQ19WRUNUKElS
UTMsIDB4NjYwKSwKIH07CiAKK3N0YXRpYyBzdHJ1Y3QgaW50Y19zZW5zZV9yZWcgc2Vuc2VfcmVn
aXN0ZXJzW10gX19pbml0ZGF0YSA9IHsKKwl7IDB4YTQwMDAwMTAsIDE2LCAyLCAvKiBJQ1IxICov
ICAgeyBJUlEwLCBJUlExLCBJUlEyLCBJUlEzLAorCQkJCQkgICAgSVJRNCwgSVJRNSwgfSB9LAor
fTsKKwogc3RhdGljIERFQ0xBUkVfSU5UQ19ERVNDKGludGNfZGVzY19pcnEsICJzaDc3MDUtaXJx
IiwgdmVjdG9yc19pcnEsIE5VTEwsCi0JCQkgTlVMTCwgcHJpb19yZWdpc3RlcnMsIE5VTEwpOwor
CQkJIE5VTEwsIHByaW9fcmVnaXN0ZXJzLCBzZW5zZV9yZWdpc3RlcnMgKTsKIAogc3RhdGljIHN0
cnVjdCBwbGF0X3NjaV9wb3J0IHNjaV9wbGF0Zm9ybV9kYXRhW10gPSB7CiAJewo=
------=_Part_5458_3789268.1203669007679--
