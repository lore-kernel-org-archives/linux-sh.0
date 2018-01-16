From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 16 Jan 2018 09:48:42 +0000
Subject: Re: [PATCH v5 7/9] v4l: i2c: Copy tw9910 soc_camera sensor driver
Message-Id: <9b71bff3-89e0-d0e1-fe6f-9e1f58708c68@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1515765849-10345-1-git-send-email-jacopo+renesas@jmondi.org>
 <1515765849-10345-8-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1515765849-10345-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com
Cc: linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/12/2018 03:04 PM, Jacopo Mondi wrote:
> Copy the soc_camera based driver in v4l2 sensor driver directory.
> This commit just copies the original file without modifying it.
> No modification to KConfig and Makefile as soc_camera framework
> dependencies need to be removed first in next commit.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
