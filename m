From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 03:42:34 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <CANqRtoS0DHMLb09-K4uRKbMsH-Mw6RzzomJR5zzJZkufQnaPfw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Fri, Jul 5, 2013 at 5:41 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 5 Jul 2013, Magnus Damm wrote:
>
>> Hi Guennadi,
>>
>> On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>
> [snip]
>
>> > +       sdhi0: sdhi@ee100000 {
>> > +               compatible = "renesas,r8a7740-sdhi";
>> > +               reg = <0 0xee100000 0 0x100>;
>> > +               interrupt-parent = <&gic>;
>> > +               interrupts = <0 165 4>;
>> > +               cap-sd-highspeed;
>> > +               status = "disabled";
>> > +       };
>> > +
>> > +       sdhi1: sdhi@ee120000 {
>> > +               compatible = "renesas,r8a7740-sdhi";
>> > +               reg = <0 0xee120000 0 0x100>;
>> > +               interrupt-parent = <&gic>;
>> > +               interrupts = <0 166 4>;
>> > +               cap-sd-highspeed;
>> > +               status = "disabled";
>> > +       };
>> > +
>> > +       sdhi2: sdhi@ee140000 {
>> > +               compatible = "renesas,r8a7740-sdhi";
>> > +               reg = <0 0xee140000 0 0x100>;
>> > +               interrupt-parent = <&gic>;
>> > +               interrupts = <0 167 4>;
>> > +               cap-sd-highspeed;
>> > +               status = "disabled";
>> > +       };
>>
>> And now we're here again using "r8a7740" for SDHI on r8a73a4.
>
> Would this be ok:
>
>                 compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";

At least it is better. Thanks.

I prefer "renesas,r8a73a4-sdhi" only, but the above is acceptable to
me as long as we remember to add "renesas,r8a73a4-sdhi" to the SDHI
driver that keeps old behaviour before updating "renesas,r8a7740-sdhi"
with features that may break r8a73a4.

Maybe we should simply add per-soc bindings to the driver to avoid
future potential issues?

Thanks,

/ magnus
