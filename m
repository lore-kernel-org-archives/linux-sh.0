From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 10:55:45 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <aec7e5c30905110355n44acb390i7309f1dccbc49616@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 7:51 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> On Mon, May 11, 2009 at 07:32:03PM +0900, Magnus Damm wrote:
>> On Mon, May 11, 2009 at 7:15 PM, Manuel Lauss
>> <mano@roarinelk.homelinux.net> wrote:
>> > On Mon, May 11, 2009 at 06:59:37PM +0900, Magnus Damm wrote:
>> >> On Mon, May 11, 2009 at 6:44 PM, Manuel Lauss
>> >> <mano@roarinelk.homelinux.net> wrote:
>> >> > On Mon, May 11, 2009 at 06:01:08PM +0900, Magnus Damm wrote:
>> >> >> From: Magnus Damm <damm@igel.co.jp>
>> >> >>
>> >> >> Update intc tables and platform data to use one linux irq
>> >> >> per maskable interrupt source instead of keeping the one-to-one
>> >> >> mapping between vectors and linux irqs.
>> >> >>
>> >> >> This fixes potential irq masking issues for sh7760 hardware
>> >> >> blocks such as DMAC/TMU2/REF.
>> >> >
>> >> > With this patch applied, my 7760 system no longer boots. ?I'll
>> >> > try to figure out why as soon as I get my JTAG probe back.
>> >>
> Disabling DMAC solves this. =A0The TMU patch also seems to work fine.

Good, thanks for testing!

>> If you have a little time to spend on this, then feel free to test by
>> #ifdefing out various INTC_VECT() to check which vector that makes the
>> boot fail. A good start may be to disable all DMA users and see if
>> that helps.
>
> I'll try to figure it out if I can find some more free time.

I guess this means that the problem lies withing the DMA driver then. =3D)

Thanks for your help!

/ magnus
