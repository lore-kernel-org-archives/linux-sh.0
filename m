From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2014 09:18:16 +0000
Subject: Re: [PATCH v4 5/9] ARM: shmobile: marzen: Enable DU device in DT
Message-Id: <CAMuHMdU2RiAv0LB0+=WS0Ufw0O9yOX4wWc_ESRJMWA7ssVMrsg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 27, 2014 at 2:23 AM, Simon Horman <horms@verge.net.au> wrote:
> I have this patch queued up but I notice that it seems to introduce
> the following warnings. Can this be addressed somehow?
>
> Warning (reg_format): "reg" property in /lvds-encoder/ports/port@0 has invalid length (4 bytes) (#address-cells = 2, #size-cells = 1)
> Warning (reg_format): "reg" property in /lvds-encoder/ports/port@1 has invalid length (4 bytes) (#address-cells = 2, #size-cells = 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /lvds-encoder/ports/port@0
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /lvds-encoder/ports/port@0
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /lvds-encoder/ports/port@1
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /lvds-encoder/ports/port@1

>> ---
>>  arch/arm/boot/dts/r8a7779-marzen.dts | 81 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
>> index 9e1b859190ca..64a5d634edc1 100644
>> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
>> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
>> @@ -69,6 +69,76 @@
>>                       gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
>>               };
>>       };
>> +
>> +     vga-encoder {
>> +             compatible = "adi,adv7123";
>> +
>> +             ports {
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     port@0 {
>> +                             reg = <0>;
>> +                             vga_enc_in: endpoint {
>> +                                     remote-endpoint = <&du_out_rgb0>;
>> +                             };
>> +                     };
>> +                     port@1 {
>> +                             reg = <1>;
>> +                             vga_enc_out: endpoint {
>> +                                     remote-endpoint = <&vga_in>;
>> +                             };
>> +                     };
>> +             };
>> +     };
>> +
>> +     vga {
>> +             compatible = "vga-connector";
>> +
>> +             port {
>> +                     vga_in: endpoint {
>> +                             remote-endpoint = <&vga_enc_out>;
>> +                     };
>> +             };
>> +     };
>> +
>> +     lvds-enc {
>> +             compatible = "thine,thc63lvdm83d";
>> +
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;

I think the two properties above should be moved to the ports node below.

>> +
>> +             ports {

---> HERE.

Yes, this can be a real PITA. I had to sprinkle lots of #address-cells = <1>
and #size-cells = <0> to the hierarchical PM domain nodes, too.

>> +                     port@0 {
>> +                             lvds_enc_in: endpoint {
>> +                                     remote-endpoint = <&du_out_rgb1>;
>> +                             };
>> +                     };
>> +                     port@1 {
>> +                             lvds_connector: endpoint {
>> +                             };
>> +                     };
>> +             };
>> +     };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
