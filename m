From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 09 Jan 2010 00:07:35 +0000
Subject: Re: [PATCH] Makefile: do not override LC_CTYPE
Message-Id: <4B47C8C7.1010507@zytor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100108115745.GA14758@sepie.suse.cz> <1262952988-16563-1-git-send-email-mmarek@suse.cz> <20100109000008.GB2319@verge.net.au>
In-Reply-To: <20100109000008.GB2319@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Michal Marek <mmarek@suse.cz>, Masami Hiramatsu <mhiramat@redhat.com>, Roland Dreier <rdreier@cisco.com>, Sam Ravnborg <sam@ravnborg.org>, Sergei Trofimovich <slyfox@inbox.ru>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On 01/08/2010 04:00 PM, Simon Horman wrote:
> 
> Personally I think it would be much better to set the locale explicitly
> as needed, where needed, such as the LC_ALL=C sledgehammer that you
> have inserted into arch/sh/tools. Or at a slightly higher level,
> offer an awk-wrapper, as it seems to be the main (only?) cause of concern.
> 

awk, sed, shell scripts, etc. all have the same problem.

	-hpa
