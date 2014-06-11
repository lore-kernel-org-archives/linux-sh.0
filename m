From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jun 2014 13:01:57 +0000
Subject: Re: [PATCH 8/8] DT: Add vendor prefix for Dialog Semiconductor Ltd.
Message-Id: <CAMuHMdVD1Rui6NL6AS2iAaw+bmXbU6juA9ugO1rFSw_5W-49tA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1402484954.git.Adam.Thomson.Opensource@diasemi.com>
	<bf4b6d7b061e66d3ca7f3dd44319b9e26ae7103f.1402484954.git.Adam.Thomson.Opensource@diasemi.com>
	<CAMuHMdWirVk+jrz40yw4=zAOFH6VTX9CXcpO01e0rK8S8VGGHw@mail.gmail.com>
	<CAL_JsqK0RqYuZ8YB1sBZK7hMXvp6oEPfAu11m95F61_kGV3Ptg@mail.gmail.com>
In-Reply-To: <CAL_JsqK0RqYuZ8YB1sBZK7hMXvp6oEPfAu11m95F61_kGV3Ptg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Jun 11, 2014 at 2:43 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Jun 11, 2014 at 7:09 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Jun 11, 2014 at 1:11 PM, Adam Thomson
>> <Adam.Thomson.Opensource@diasemi.com> wrote:
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> @@ -36,6 +36,7 @@ dallas        Maxim Integrated Products (formerly Dallas Semiconductor)
>>>  davicom        DAVICOM Semiconductor, Inc.
>>>  denx   Denx Software Engineering
>>>  digi   Digi International Inc.
>>> +dlg    Dialog Semiconductor Ltd.
>>
>> "diasemi" has been proposed before
>> https://groups.google.com/forum/#!msg/linux.kernel/htUxLpV_Ng0/ClJVAxgK4e4J
>>
>> "dialog", "diasemi", and "dlg" all seem to be already in use...
>
> dlg is the correct one and seems to be the most widely used, so we
> should go with that and mark the others deprecated.
>
> diasemi is documented for the da9210, but not used anywhere.

It users are queued in Simon's tree, for two Renesas boards.

> There appears to be 2 different da9053 bindings. I'd guess the dialog
> variant used on 2 i.MX boards is not used. Other i.MX boards use the
> dlg version. I'm not sure what is going on with da9055. Please sort
> these out.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
