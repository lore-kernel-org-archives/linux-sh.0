From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Mar 2014 01:30:15 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: rcar-gen2: Cache Mode Monitor Register Value
Message-Id: <20140313013015.GK25813@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1394649890-23485-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394649890-23485-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 12, 2014 at 07:44:49PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> The MD pins are sampled at reset time, hence the read value will always be
> the same, and we can avoid the overhead of ioremapping the register on
> every read.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Thanks, I have queued this up.
