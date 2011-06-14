From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Jun 2011 06:33:30 +0000
Subject: Re: [PATCH] sh, exec: remove redundant set_fs(USER_DS)
Message-Id: <20110614063330.GD17891@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com> <1307642718-22257-1-git-send-email-minipli@googlemail.com> <20110609155630.0f734351.akpm@linux-foundation.org> <1307711448-16289-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1307711448-16289-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathias Krause <minipli@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 10, 2011 at 03:10:48PM +0200, Mathias Krause wrote:
> The address limit is already set in flush_old_exec() so those calls to
> set_fs(USER_DS) are redundant.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>

Applied, thanks.
