From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 05:27:15 +0000
Subject: Re: [PATCH v3 13/13] sh: select HAVE_SECCOMP_FILTER
Message-Id: <20110602052714.GB6087@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com> <1306897845-9393-13-git-send-email-wad@chromium.org>
In-Reply-To: <1306897845-9393-13-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, kees.cook@canonical.com, torvalds@linux-foundation.org, tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, linux-sh@vger.kernel.org

On Tue, May 31, 2011 at 10:10:45PM -0500, Will Drewry wrote:
> Add support for CONFIG_SECCOMP_FILTER by selecting HAVE_SECCOMP_FILTER.
> ---
>  arch/sh/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
