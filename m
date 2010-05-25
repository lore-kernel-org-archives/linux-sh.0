From: Roland McGrath <roland@redhat.com>
Date: Tue, 25 May 2010 19:11:46 +0000
Subject: Re: [Uclinux-dist-devel] [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix
Message-Id: <20100525191146.E70E549A54@magilla.sf.frob.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100522165401.GB19573@redhat.com>
	<1266280229-18469-1-git-send-email-vapier@gentoo.org>
	<1274431345-22366-1-git-send-email-vapier@gentoo.org>
	<20100521162659.GA16193@redhat.com>
	<20100521183512.4477F40476@magilla.sf.frob.com>
	<20100522165320.GA19573@redhat.com>
	<25539.1274711817@redhat.com>
	<20100524151445.GA6393@redhat.com>
	<20100524234250.F158849A56@magilla.sf.frob.com>
	<AANLkTinpMp1yZ2c5B5O7aT2NR57zBHlggvUXZ58bLGv2@mail.gmail.com>
In-Reply-To: Mike Frysinger's message of  Monday, 24 May 2010 21:29:34 -0400 <AANLkTinpMp1yZ2c5B5O7aT2NR57zBHlggvUXZ58bLGv2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, Andrew Morton <akpm@linux-foundation.org>

> are you suggesting the FDPIC additions are ill-advised as well ?
> curious how you would have implemented this if that's the case ...

They are certainly not as dismal as the arch PTRACE_PEEKUSR delivering
mm->fields.  But, frankly I don't think ptrace is the right mechanism for
delivering any read-only, process-shared information.  You can use some
/proc/pid/foo for that.  (The "dismal" cases deliver things like
start_code, which is already available in /proc/pid/stat.)


Thanks,
Roland
