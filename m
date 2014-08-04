From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Aug 2014 20:39:53 +0000
Subject: Re: [PATCH 2/4] media: rcar_vin: Ensure all in-flight buffers are returned to error state before sto
Message-Id: <53DFEF99.7040503@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404812474-7627-1-git-send-email-ian.molton@codethink.co.uk> <1404812474-7627-3-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1404812474-7627-3-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian.molton@codethink.co.uk>, linux-media@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, g.liakhovetski@gmx.de, m.chehab@samsung.com, vladimir.barinov@cogentembedded.com, magnus.damm@gmail.com, horms@verge.net.au, linux-sh@vger.kernel.org

On 07/08/2014 01:41 PM, Ian Molton wrote:

> Videobuf2 complains about buffers that are still marked ACTIVE (in use by the driver) following a call to stop_streaming().

> This patch returns all active buffers to state ERROR prior to stopping.

> Note: this introduces a (non fatal) race condition as the stream is not guaranteed to be stopped at this point.

> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> Signed-off-by: William Towle <william.towle@codethink.co.uk>

    Fixed kernel WARNINGs for me! \o/
    Ian, perhaps it makes sense for me to take these patches into my hands?

WBR, Sergei

