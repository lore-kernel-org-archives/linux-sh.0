From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 19 Jan 2011 03:13:46 +0000
Subject: Re: [PATCH] sh: Fix sh build failure when CONFIG_SFC=m
Message-Id: <20110119031345.GC19486@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1295384134-26329-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1295384134-26329-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 18, 2011 at 09:55:34PM +0100, Aurelien Jarno wrote:
> CONFIG_SFC=m uses topology_core_cpumask() which, for sh, expects
> cpu_core_map to be exported. It is not. This patch exports the needed
> symbol.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied, thanks.
