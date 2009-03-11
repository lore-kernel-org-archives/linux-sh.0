From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Mar 2009 08:29:14 +0000
Subject: Re: [PATCH] input: sh_keysc suspend can use to_platform_device()
Message-Id: <20090311082914.GD6281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090311080423.2006.22858.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090311080423.2006.22858.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, soni.trilok@gmail.com, linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 05:04:23PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch changes sh_keysc to use to_platform_device()
> for suspend. Thanks to Trilok Soni for this suggestion.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied on top of the earlier patch, with Trilok's Reviewed-by, thanks.
