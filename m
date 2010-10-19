From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 19 Oct 2010 02:47:15 +0000
Subject: Re: [RFC/PATCH] sh: Add 32bit cou mode to cpu_flags
Message-Id: <20101019024715.GF5809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 19, 2010 at 10:43:29AM +0900, Nobuhiro Iwamatsu wrote:
> There is not method to confirm which of 32bit mode or 29bit mode Linux
> kernel works.
> This patch adds a mode to cpu_flags and can confirm it from auxv and proc
> filesystem.
> 
Is there some use you had in mind for this?
