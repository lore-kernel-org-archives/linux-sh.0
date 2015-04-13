From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Apr 2015 10:02:24 +0000
Subject: Re: [PATCH] [RFC] OF: probe order dependency aware of_platform_populate
Message-Id: <CAMuHMdWBsmtCH=oMzJYkY-hnGwQ8c5byNMEW=YRAxq528Wwcqg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418731891-24768-1-git-send-email-pantelis.antoniou@konsulko.com>
	<20150319191834.5346CC40A35@trevor.secretlab.ca>
	<8E250936-B06C-40B4-8C34-557D2361CAF6@konsulko.com>
	<CAMuHMdU=Zh00DnkAdAJBaAVn8LthYoRoGCVdFAhxQmWaEGHfkw@mail.gmail.com>
	<1B3AF599-4A64-4FB0-BFB0-0C0544917C6C@konsulko.com>
	<CAMuHMdWgAzkAJ-ix9NYc46yJRGPHCpmimOjF=HUYprxdgtzkaw@mail.gmail.com>
	<20150402023803.E6A4DC4076D@trevor.secretlab.ca>
	<CAMuHMdWVTsog2_9iyUEBWm-7xonvNibTTbOY5YxvpAhffUXdcg@mail.gmail.com>
	<CAL_Jsq+9rYTvxX=Y6md5hgNhcBjbuM1m8Q3Y0gNkrV6yaDBskg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+9rYTvxX=Y6md5hgNhcBjbuM1m8Q3Y0gNkrV6yaDBskg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Rob,

On Wed, Apr 8, 2015 at 3:40 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Apr 8, 2015 at 3:42 AM, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
>> On Thu, Apr 2, 2015 at 4:38 AM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>> On Mon, 30 Mar 2015 15:27:27 +0200
>>> , Geert Uytterhoeven <geert@linux-m68k.org>
>>>  wrote:
>>>> On Tue, Mar 24, 2015 at 6:56 PM, Pantelis Antoniou
>>>> <pantelis.antoniou@konsulko.com> wrote:
>>>> >> On Mar 24, 2015, at 07:50 , Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
>>>> >> IIUC, this would fix the issue I worked around in "ARM: shmobile: r=
8a73a4:
>>>> >> Move pfc node to work around probe ordering bug"?
>>>> >> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/comm=
it/?h=3Dr8a73a4-ccf-and-multiplatform-for-v4.1&id=E4ba0a9bddff3ba52cec10041=
4d2f178440efc91
>>
>>> There are two ways to fix this so that .dtb order doesn't matter. The
>>> dirty hack is to change the pfc driver to use subsys_initcall (level 4)
>>> or later so that it happens after the devices are registered. The second
>>
>> I've just tried that, and it doesn't work.
>>
>>> solution is to make the pfc drivers able to return -EPROBE_DEFER, but
>>> that also requires fixing deferred probe to start retrying devices
>>> before late_initcall time. Right now there is a holdoff flag that
>>
>> All the pfc driver can detect is that some platform_device.resource[i] a=
re
>> empty (resource_type zero). Returning -EPROBE_DEFER won't help,
>> as the resource won't change later.
>>
>> The problem is not the initialization order of the device drivers, but t=
he
>> creation order of the platform devices.
>>
>> of_device_alloc() silently (except for the pr_debug() message) ignores
>> any failures to setup IRQ resources. Hence platform devices for interrupt
>> providers must be created before platform devices for interrupt consumer=
s,
>> which is what the reordering in DT fixes.
>
> This doesn't sound right. It ignores failures because platform_get_irq
> will parse the interrupts when called rather than just using the
> resource struct and will return EPROBE_DEFER if the irq resource is
> not ready. We left the of_device_alloc code in to be safe, but we
> should be able to remove it.

Thanks, using platform_get_irq() (and propagating EPROBE_DEFER) instead of
accessing the platform_device's resources directly indeed does work, but wi=
ll
require some rework in the sh-pfc driver.
One more thing to consider for a "porting your driver to DT" tutorial ;-)

One side effect is that almost all drivers now end up being probe-deferred,=
 as
the pinctrl configuration can't be done until the pfc driver is active.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
