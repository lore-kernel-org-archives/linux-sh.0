From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Tue, 04 May 2010 07:38:28 +0000
Subject: Missing of "Uncompressing Linux... " message at boot sequence
Message-Id: <4BDFCEF4.8010607@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SuperH folks,

In arch/sh/boot/compressed/misc.c the function puts() is defined like this:

int puts(const char *s)
{
	/* This should be updated to use the sh-sci routines */
	return 0;
}

Of course this makes no output.
So I cannot see the message "Uncompressing Linux... Ok, booting the 
kernel." now.
# The change was made at abec86a80247ab3a40d2afc9c8e8c26efcab2391

So I have a question:
Do you have any plan to revive the "Uncompressing" message?

The comment says that puts() should use the routines of sh-sci.
But sh-sci is the thing built in vmlinux, so I think using it from 
misc.c is hard.
To revive it, big change will be required.

If you have a plan to revive the message, I'd like to co-operate.
Because I'm working on new board support, serial output is a big problem 
for me.

Thanks,
	Hitoshi
