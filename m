From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 17:47:23 +0000
Subject: [PATCH 16/22] clocksource: sh_mtu2: Remove FSF mail address from GPL notice
Message-Id: <1393955249-18736-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do not include the paragraph about writing to the Free Software
Foundation's mailing address from the sample GPL notice. The FSF has
changed addresses in the past, and may do so again. Linux already
includes a copy of the GPL.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_mtu2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 3a37857..510bd32 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -11,10 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/init.h>
-- 
1.8.3.2

