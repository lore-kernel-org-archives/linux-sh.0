From: Simon Horman <horms@verge.net.au>
Date: Wed, 28 Oct 2015 22:34:01 +0000
Subject: Re: [PATCH] ARM: shmobile: henninger: remove board DT
Message-Id: <20151028223358.GA27318@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <2890345.M5sT48V28r@wasted.cogentembedded.com>
In-Reply-To: <2890345.M5sT48V28r@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:29AM +0300, Sergei Shtylyov wrote:
> The Henninger low cost board was never sold and so  had  no  users outside
> Renesas (and Cogent Embedded). Instead Renesas  has made the Porter  board
> which has mostly similar hardware. Now that the Porter board support is on
> par with Henninger, we can remove  the Henninger's device tree file.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up for v4.5.
