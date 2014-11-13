From: gsantosh@codeaurora.org
Date: Thu, 13 Nov 2014 03:02:04 +0000
Subject: Question on Compressed offload session
Message-Id: <85499f52ebd29581bf58b9cafbae6864.squirrel@www.codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, grant.likely@linaro.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi All,

The Question is for the compressed offload session.

For a generic codec driver during the startup function it will set some of
the hw_constraints rule similarly like this.

        snd_pcm_hw_constraint_list(substream->runtime, 0,
                    SNDRV_PCM_HW_PARAM_RATE,
                    &constraints_12_24);

pcm_lib.c will try to add the rule to the runtime structure by accessing
the pointers which will be initialized during opening of the session,
as The Constraints added by the codec driver will be updated in the

struct snd_pcm_hw_constraints of runtime structure which will be part of
substream handle.

But for the compressed offload I do not see the initialization done for HW
constraints, as done in pcm session

2092int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
2093			   struct file *file,
2094			   struct snd_pcm_substream **rsubstream)

most of the existing drivers which has the hw_constraint_list code will
not be applicable for compress offload session, how to solve this?

Regards,
Santosh M G.
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum,a Linux Foundation Collaborative Project


