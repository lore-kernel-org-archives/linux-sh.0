From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Mar 2009 22:44:55 +0000
Subject: Re: [PATCH] sh: Add depend on MMU for kexec
Message-Id: <20090330224455.GB19535@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49CB3DA5.1030009@renesas.com>
In-Reply-To: <49CB3DA5.1030009@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 26, 2009 at 05:32:37PM +0900, Nobuhiro Iwamatsu wrote:
> Kexec is not likely to work on NON-MMU CPU because this added
> depend on MMU for kexec.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
