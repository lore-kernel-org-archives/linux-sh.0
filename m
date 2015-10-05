From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 03:03:55 +0000
Subject: Re: [PATCH] ARM: shmobile: fix SILK board name
Message-Id: <20151005030355.GD29979@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <6818713.ulHphNVRsJ@wasted.cogentembedded.com>
In-Reply-To: <6818713.ulHphNVRsJ@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Oct 03, 2015 at 12:53:38AM +0300, Sergei Shtylyov wrote:
> Unfortunately, the SILK board bindings were not quite correct, as the  board
> name should be all caps.  Fix that,  adding the board model #  in parens and
> removing stray semicolon.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up.
