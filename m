From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jun 2008 05:50:09 +0000
Subject: Re: [PATCH] sh: fix seq_file memory leak
Message-Id: <20080624055009.GA22890@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4860866F.7050703@cn.fujitsu.com>
In-Reply-To: <4860866F.7050703@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Jun 24, 2008 at 01:30:23PM +0800, Li Zefan wrote:
> When using single_open(), single_release() should be used instead
> of seq_release(), otherwise there is a memory leak.
> 
> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>

Good catch. Applied, thanks.
