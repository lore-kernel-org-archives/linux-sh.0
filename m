From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Apr 2010 06:46:16 +0000
Subject: Re: [patch 13/14] sh: invoke oom-killer from page fault
Message-Id: <20100426064616.GD11770@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100422160613.723698029@suse.de> <20100422161224.768947406@suse.de>
In-Reply-To: <20100422161224.768947406@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org

On Fri, Apr 23, 2010 at 02:06:26AM +1000, npiggin@suse.de wrote:
> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-sh@vger.kernel.org
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Applied with David's Acked-by, thanks.
