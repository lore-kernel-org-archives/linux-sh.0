From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Sun, 12 Jul 2020 11:11:18 +0000
Subject: [PATCH] sh: Replace HTTP links with HTTPS ones
Message-Id: <20200712111118.24916-1-grandmaster@al2klimov.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
In-Reply-To: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Strange... it seems something went wrong while scanning.
 Now better?

 arch/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9fc2b010e938..2fb9233f031e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -630,7 +630,7 @@ config SMP
 	  Y to "Enhanced Real Time Clock Support", below.
 
 	  See also <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO
-	  available at <http://www.tldp.org/docs.html#howto>.
+	  available at <https://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
 
-- 
2.27.0
