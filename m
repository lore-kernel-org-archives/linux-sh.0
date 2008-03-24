From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 Mar 2008 06:13:18 +0000
Subject: Re: [PATCH] Fix sh_keysc double free
Message-Id: <20080324061318.GB17734@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080321111446.13134.8863.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080321111446.13134.8863.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org, linux-sh@vger.kernel.org

On Fri, Mar 21, 2008 at 08:14:46PM +0900, Magnus Damm wrote:
> Avoid double free situation from happening by removing input_free_device() 
> after input_unregister_device(). Suggested by Dmitry Torokhov.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
