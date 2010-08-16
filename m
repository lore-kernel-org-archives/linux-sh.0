From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Aug 2010 07:34:13 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile irq rollback fix
Message-Id: <AANLkTikXn-2avPceVgj4uoCpyQNLNbPjGJJ7DHXgKFa5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100802071637.18054.76993.sendpatchset@t400s>
	<20100810151828.36a77cc3@hyperion.delvare>
	<AANLkTikQuCX7YC1tQ5MvwBdgxg1LE6k9f98-3M8khBJ6@mail.gmail.com>
	<20100816082427.626ea303@hyperion.delvare>
In-Reply-To: <20100816082427.626ea303-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Aug 16, 2010 at 3:24 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 16 Aug 2010 10:59:06 +0900, Magnus Damm wrote:
>> On Tue, Aug 10, 2010 at 10:18 PM, Jean Delvare <khali@linux-fr.org> wrot=
e:
>> > On Mon, 02 Aug 2010 16:16:37 +0900, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Update the i2c-sh_mobile driver to properly free
>> >> interrupts. The function sh_mobile_i2c_hook_irqs()
>> >> is fixed so module both unload and load are working
>> >> as expected.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >> ---
>> >>
>> >> =A0drivers/i2c/busses/i2c-sh_mobile.c | =A0 23 +++++++++++++----------
>> >> =A01 file changed, 13 insertions(+), 10 deletions(-)
>> >>
>> >> --- 0001/drivers/i2c/busses/i2c-sh_mobile.c
>> >> +++ work/drivers/i2c/busses/i2c-sh_mobile.c =A0 2010-08-02 15:14:48.0=
00000000 +0900
>> >> @@ -538,15 +538,17 @@ static int sh_mobile_i2c_hook_irqs(struc
>> >> =A0{
>> >> =A0 =A0 =A0 struct resource *res;
>> >> =A0 =A0 =A0 int ret =3D -ENXIO;
>> >> - =A0 =A0 int q, m;
>> >> - =A0 =A0 int k =3D 0;
>> >> - =A0 =A0 int n =3D 0;
>> >> + =A0 =A0 int n, k =3D 0;
>> >
>> > You can't really hope to get the code right with such variable names.
>>
>> And your suggestion is...? If you see something wrong with the code
>> please let me know.
>
> Nothing specific. I'm just trying to make you realize that one-letter
> variable names don't carry any meaning and thus make the code harder to
> write, read and debug.

Yes, I admit that four one-letter variables in a single function is
begging for trouble. Having one or two one-letter variable names is
not so bad IMO.

I guess one-letter variable names is my attempt to stick to pure
function and avoid going in the direction of endless coding style
discussions. =3D)

Cheers,

/ magnus
