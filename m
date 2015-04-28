From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2015 11:21:03 +0000
Subject: Re: [PATCH] usb: phy: rcar-gen2-usb: Fix USBHS_UGSTS_LOCK value
Message-Id: <CAMuHMdXpyjJbrcgiJzDSHJpY=KfPzZBZytwZyJsL8pFWZjuBzg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Tue, Apr 28, 2015 at 12:25 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> Sent: Tuesday, April 28, 2015 6:55 PM
>> On Tue, Apr 28, 2015 at 3:36 AM, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> >> Sent: Tuesday, April 28, 2015 4:45 AM
>> >> On Thu, Apr 02, 2015 at 08:22:34PM +0900, Yoshihiro Shimoda wrote:
>> >> > According to the technical update (No. TN-RCS-B011A/E), the UGSTS LOCK
>> >> > bit location is bit 8, not bits 9 and 8. So, this patch fixes the
>> >> > USBHS_UGSTS_LOCK value.
>> >> >
>> >> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> >>
>> >> this doesn't apply to v4.1-rc1, if it's still needed, please rebase.
>> >
>> > Thank you for the notice. I found that this patch has been already merged in v4.1-rc1 by Greg.
>>
>> drivers/usb/phy/phy-rcar-gen2-usb.c (which supports legacy platform data only)
>> is unused since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove
>> legacy board support").
>>
>> It's my understanding this driver has been replaced by a new driver, which
>> supports DT only (drivers/phy/phy-rcar-gen2.c).
>
> Yes. You are correct.
>
>> That driver still has the wrong value:
>> #define USBHS_UGSTS_LOCK                0x00000300 /* The manuals have 0x3 */
>>
>> So:
>>   1) Shouldn't drivers/phy/phy-rcar-gen2.c be fixed?
>
> I already submitted such a patch. However, the patch is not merged yet.
> (I should have sent a ping or something about this patch.)
> http://thread.gmane.org/gmane.linux.ports.sh.devel/45089

Right. Sorry, I forgot about that patch.

>>   2) Shouldn't drivers/usb/phy/phy-rcar-gen2-usb.c et al be removed?
>
> We should remove this code because legacy board codes were already removed.
> (In other words, nobody uses this code now.)

I'll remove it, while you can enjoy Golden Week...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
