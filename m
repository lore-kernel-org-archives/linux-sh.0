From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Feb 2018 08:20:17 +0000
Subject: Re: [PATCH v11 04/10] ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
Message-Id: <20180223082017.mwdcw7gj4qegbvar@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1519295846-11612-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519295846-11612-5-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1519295846-11612-5-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, hverkuil@xs4all.nl, mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:37:20AM +0100, Jacopo Mondi wrote:
> Add Capture Engine Unit (CEU) node to device tree.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

I have marked this patch as deferred as it depends on the binding for
"renesas,r7s72100-ceu".  Please repost or otherwise ping me once that
dependency has been accepted.

