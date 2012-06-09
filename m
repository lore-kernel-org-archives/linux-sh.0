From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 09 Jun 2012 09:14:26 +0000
Subject: Re: [PATCH 1/6] sh: fix compiler warning by properly inlining flat_set_persistent()
Message-Id: <20120609091426.GA10170@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
In-Reply-To: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-sh@vger.kernel.org

On Sat, Jun 09, 2012 at 05:13:26AM -0300, Ezequiel Garcia wrote:
> This patch removes the following warning:
> fs/binfmt_flat.c:752: warning: unused variable ???persistent???
> There is neither change in functionality, nor extra code generated.
> 
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>

That's what the cast was for, with what gcc version did that stop
working?
