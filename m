From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Mar 2013 04:09:37 +0000
Subject: Re: [PATCH 1/3] clocksource: sh_cmt: Add Device Tree probing
Message-Id: <20130304040935.GC26475@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
 <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 01, 2013 at 11:45:30AM -0600, Bastian Hecht wrote:
> We add the capabilty to probe SH CMT timer devices using Device Tree
> setup.
> 
> We can deduce former platform data by the device IDs and channel
> IDs of our timer instances, so we choose this more intuitive info as our
> DT properties.
> 
I wonder if it makes more sense to attempt to create a more generalized
binding, as what you have here is pretty much uniform for all of
CMT/TMU/MTU2. Perhaps having a general sh-timer binding would be cleaner,
while letting each timer plug the compatible string it cares about.
