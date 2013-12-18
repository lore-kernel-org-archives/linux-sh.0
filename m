From: Kees Cook <keescook@chromium.org>
Date: Wed, 18 Dec 2013 18:19:54 +0000
Subject: [PATCH v4] provide -fstack-protector-strong build option
Message-Id: <1387390796-5860-1-git-send-email-keescook@chromium.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This reorganizes the build options for CONFIG_CC_STACKPROTECTOR so that
the new CONFIG_CC_STACKPROTECTOR_STRONG can be used when building with
a compiler that supports it.

Now with objdump analysis.

-Kees

