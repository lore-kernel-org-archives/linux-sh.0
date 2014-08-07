From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 07 Aug 2014 08:34:57 +0000
Subject: Re: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <87y4v0k89a.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
	<87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
	<20140807001805.GE32652@verge.net.au>
	<8761i5kuel.wl%kuninori.morimoto.gx@renesas.com>
	<20140807011025.GA3284@verge.net.au>
	<8738d9kojw.wl%kuninori.morimoto.gx@gmail.com>
	<CANqRtoSu2cZyY2YELUzPF86UAz+=TFtBYsnmotpNDEh9FEhp1Q@mail.gmail.com>
	<87zjfgkhae.wl%kuninori.morimoto.gx@gmail.com>
	<CANqRtoR1kn0VjDiYy24hJueeL6Lxs5yxAeTEMQ-kNHn76EYMDQ@mail.gmail.com>
In-Reply-To: <CANqRtoR1kn0VjDiYy24hJueeL6Lxs5yxAeTEMQ-kNHn76EYMDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>


Hi Magnus

> With this in mind I think the best way forward is as follows:
> A) Keep on using per-SoC compatible string unless it is documented somewhere
> and in parallel
> B) Work on getting per-device hardware version number from hardware device team
(snip)
> From my point of view your proposal adds problematic dependencies for
> each device without too much upside. The problem will happen over time
> when adding features. It is in my opinion easier to just add the
> compatible string entry for a new SoC together with the rest of the
> SoC support activity. There is no easy way out when the hardware is
> changing - we have to modify the code anyway! Of course, if the
> hardware is not changing then it is a different story. But in such
> case we need to have documented compatibility somewhere...
> 
> What is your opinion about "B) per-device hardware version number"?

According to HW team, they are creating 2 type of datasheet now.
One is "R-Car Gen2 common datasheet",
and the other is "R-Car SoC specify datasheet".
Not, HW version though.

I could understand about your concern.
But, it is always happen on all code
which is used from many platform/driver/framework.
It is not only DT compatible issue.

I still can't give up adding generation level compatible.
So how about this idea ?
Now, our driver / platform are like this.
SoC level matching only.

driver
	{ .compatible = "renesas,xxx-r8a7790", .data = xxx_gen2_dt_config },
	{ .compatible = "renesas,xxx-r8a7791", .data = xxx_gen2_dt_config },
	{ .compatible = "renesas,xxx-r8a7792", .data = xxx_gen2_dt_config },

platform
	compatible = "renesas,xxx-r8a7790";


Now, we add generation level compatible to platform side only.
We don't know what is "gen2" mean at this point.
But, this is no problem, because driver matching is happen on SoC level.

driver
	{ .compatible = "renesas,xxx-r8a7790", .data = xxx_gen2_dt_config },
	{ .compatible = "renesas,xxx-r8a7791", .data = xxx_gen2_dt_config },
	{ .compatible = "renesas,xxx-r8a7792", .data = xxx_gen2_dt_config },

platform
-	compatible = "renesas,xxx-r8a7790";
+	compatible = "renesas,xxx-r8a7790", "renesas,xxx-gen2";

In the future, if our driver are growup enough,
and we could confirm there is no difference between r8a7790/1/2 in HW,
and we could confirm there is no drfference between r8a7790/1/2 in SW,
then, we can add generation level compatible,
and remove SoC level compatible in driver side,

driver
+	{ .compatible = "renesas,xxx-gen2",    .data = xxx_gen2_dt_config },
-	{ .compatible = "renesas,xxx-r8a7790", .data = xxx_gen2_dt_config },
-	{ .compatible = "renesas,xxx-r8a7791", .data = xxx_gen2_dt_config },
-	{ .compatible = "renesas,xxx-r8a7792", .data = xxx_gen2_dt_config },

platform
	compatible = "renesas,xxx-r8a7790", "renesas,xxx-gen2";

If there is non-compatible feature, we can keep it.
like this

driver
+	{ .compatible = "renesas,xxx-gen2",    .data = xxx_gen2_dt_config },
-	{ .compatible = "renesas,xxx-r8a7790", .data = xxx_gen2_dt_config },
-	{ .compatible = "renesas,xxx-r8a7791", .data = xxx_gen2_dt_config },
-	{ .compatible = "renesas,xxx-r8a7792", .data = xxx_gen2_dt_config },
+	{ .compatible = "renesas,xxx-r8a7792", .data = xxx_r8a7792_dt_config },

platform
	compatible = "renesas,xxx-r8a7790", "renesas,xxx-gen2";

This approach has no effect to current feature,
and can keep compatible for current and future,
and can reduce / cleanup driver in the future.

>> But yes, we want to know which SoC is supported.
>> We can use Document/devicetree/...txt for this purpose
>
> I agree about that portion. =)

Thank you :)

Best regards
---
Kuninori Morimoto
