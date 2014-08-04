From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Aug 2014 20:00:20 +0000
Subject: Re: Resend: [PATCH 0/4] rcar_vin: fix soc_camera WARN_ON() issues.
Message-Id: <53DFE654.1000102@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404812474-7627-1-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1404812474-7627-1-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian.molton@codethink.co.uk>, linux-media@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, g.liakhovetski@gmx.de, m.chehab@samsung.com, vladimir.barinov@cogentembedded.com, magnus.damm@gmail.com, horms@verge.net.au, linux-sh@vger.kernel.org

Hello.

On 07/08/2014 01:41 PM, Ian Molton wrote:

> Resent to include the author and a couple of other interested parties :)

    Thank you (despite you didn't include me :-).

> This patch series provides fixes that allow the rcar_vin driver to function
> without triggering dozens of warnings from the videobuf2 and soc_camera layers.

> Patches 2/3 should probably be merged into a single, atomic change, although
> patch 2 does not make the existing situation /worse/ in and of itself.

    Perhaps it's worth to just swap patches 2 & 3...

> Patch 4 does not change the code logic, but is cleaner and less prone to
> breakage caused by furtutre modification. Also, more consistent with the use of
> vb pointers elsewhere in the driver.

    It's not a good practice to post fixes and clean-ups in a single series.

> Comments welcome!

    I've just tested the whole series, so here's my:

Tested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei

