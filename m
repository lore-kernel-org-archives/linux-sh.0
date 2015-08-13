From: William Towle <william.towle@codethink.co.uk>
Date: Thu, 13 Aug 2015 11:36:48 +0000
Subject: Renesas Lager: Device Tree entries for VIN HDMI input, version 2
Message-Id: <1439465811-936-1-git-send-email-william.towle@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>

  Version 2 ... removes some redundant configuration from device nodes,
and provides some supplementary logic for automatic initialisation of
state->pdata.default_input based on the hardware present.

  (Obsoletes corresponding parts of "HDMI and Composite capture on
Lager...", published previously)

Cheers,
  Wills.

To follow:
	[PATCH 1/3] ARM: shmobile: lager dts: Add entries for VIN HDMI input
	[PATCH 2/3] media: adv7604: automatic "default-input" selection
	[PATCH 3/3] ARM: shmobile: lager dts: specify default-input for
